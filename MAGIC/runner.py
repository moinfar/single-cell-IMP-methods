import os, argparse
import numpy as np


# This function is originally obtained from MAGIC repo (https://github.com/KrishnaswamyLab/MAGIC/blob/master/python/magic/MAGIC.py)
# Note that default value for --cell-axis is changed.

def parse_args():
    p = argparse.ArgumentParser(description='MAGIC', formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    p.add_argument('--filetype', default='csv',
                   choices=['csv', '10x', '10x_HDF5', 'mtx'],
                   help='what is the file type of your original data?')
    p.add_argument('-i', '--input', metavar='FILE', default='input_count.csv', type=str,
                   help='File path of input data file.')
    p.add_argument('-o', '--output', metavar='FILE', default='imputed_count.csv', type=str,
                   help='File path of where to save the MAGIC imputed data (in csv format).')

    a = p.add_argument_group('data loading parameters')
    a.add_argument('-g', '--genome', metavar='G',
                    help='Genome must be specified when loading 10x_HDF5 data.')
    a.add_argument('--gene-name-file', metavar='GN', 
                    help='Gene name file must be specified when loading mtx data.')
    a.add_argument('--use-ensemble-ids', default=False, action='store_true',
                    help='Use ensemble IDs instead of gene names.')
    a.add_argument('--cell-axis', metavar='CA', default='columns',
                    choices=['rows', 'columns'], 
                    help='When loading a csv, specify whether cells are on rows or columns.')
    a.add_argument('--skip-rows', default=0, type=int,
                    help='When loading a csv, number of rows to skip after the header row.')
    a.add_argument('--skip-columns', default=0, type=int,
                    help='When loading a csv, number of columns to skip after the header columns.')

    n = p.add_argument_group('normalization/filtering parameters')
    n.add_argument('-n', '--no-normalize', default=True, action='store_false',
                    help='Do not perform library size normalization on the data')
    n.add_argument('-l', '--log-transform', metavar='L', default=None, type=float,
                    help='Log-transform data with the specified pseudocount.')
    n.add_argument('--mols-per-cell-min', default=0, type=int,
                    help='Minimum molecules/cell to use in filtering.')
    n.add_argument('--mols-per-cell-max', default=np.inf, type=int,
                    help='Maximum molecules/cell to use in filtering.')

    m = p.add_argument_group('MAGIC parameters')
    m.add_argument('-p', '--pca-components', metavar='P', default=20, type=int,
                   help='Number of pca components to use when running MAGIC.')
    m.add_argument('--pca-non-random', default=True, action='store_false',
                    help='Do not used randomized solver in PCA computation.')
    m.add_argument('-t', metavar='T', default=None, type=int,
                    help='t parameter for running MAGIC. Default = None, in this case, the optimal t will be calculated .')
    m.add_argument('-k', metavar='K', default=30, type=int,
                    help='Number of nearest neighbors to use when running MAGIC.')
    m.add_argument('-ka', metavar='KA', default=10, type=int,
                    help='knn-autotune parameter for running MAGIC (Default = 10).')
    m.add_argument('-e', '--epsilon', metavar='E', default=1, type=int,
                    help='Epsilon parameter for running MAGIC (Default = 1).')
    m.add_argument('-r', '--rescale', metavar='R', default=99, type=int,
                    help='Percentile to rescale data to after running MAGIC.')
    m.add_argument('--plot', default=False, action='store_true',
                    help='Plot R2 plot generated in optimal t calculation.')
    m.add_argument('--t-max', metavar='TM', default=12, type=int,
                    help='Maximum t value used in optimal t calculation.')
    m.add_argument('--n-genes', metavar='NG', default=500, type=int,
                    help='Number of genes to use in optimal t calculation, a smaller number of genes speeds up the calculation.')

    try:
        return p.parse_args()
    except ArgumentParserError:
        raise


args = parse_args()
print("run with these parametres: %s" % str(args))

if args.cell_axis == "rows":
    print(">>> Assuming that each row is a cell. <<<")
else:
    print(">>> Assuming that each column is a cell. <<<")


args.data_file = os.path.join("/data", args.input)
delattr(args, 'input')
args.output_file = os.path.join("/data", args.output)
delattr(args, 'output')

if not os.path.exists(args.data_file):
    raise Exception("File `%s` not exists. Did you mount `/data` volume into docker?" % args.data_file )

import magic


if args.filetype == 'csv':
    scdata = magic.mg.SCData.from_csv(os.path.expanduser(args.data_file), 
                                        data_type='sc-seq', normalize=False, 
                                        cell_axis=0 if args.cell_axis=='rows' else 1,
                                        rows_after_header_to_skip=args.skip_rows,
                                        cols_after_header_to_skip=args.skip_columns)
elif args.filetype == 'mtx':
    scdata = magic.mg.SCData.from_mtx(os.path.expanduser(args.data_file),
                                        os.path.expanduser(args.gene_name_file), normalize=False)
elif args.filetype == '10x':
    scdata = magic.mg.SCData.from_10x(os.path.expanduser(args.data_file), normalize=False, 
                                        use_ensemble_id=args.use_ensemble_ids)

elif args.filetype == '10x_HDF5':
    scdata = magic.mg.SCData.from_10x_HDF5(os.path.expanduser(args.data_file), args.genome, 
                                            normalize=False, use_ensemble_id=args.use_ensemble_ids)

scdata.filter_scseq_data(filter_cell_min=args.mols_per_cell_min, filter_cell_max=args.mols_per_cell_max)

if args.no_normalize:
    scdata = scdata.normalize_scseq_data()

if args.log_transform != None:
    scdata.log_transform_scseq_data(pseudocount=args.log_transform)

scdata.run_magic(n_pca_components=args.pca_components, random_pca=args.pca_non_random, t=args.t,
                    k=args.k, ka=args.ka, epsilon=args.epsilon, rescale_percent=args.rescale,
                    compute_t_make_plots=args.plot, t_max=args.t_max, compute_t_n_genes=args.n_genes)

# This condition is added to preserve cell_axis
if args.cell_axis == "rows":
    scdata.magic.to_csv(os.path.expanduser(args.output_file))
else:
    result = scdata.magic.data
    result.columns = [col.split(scdata.magic._data_prefix)[1] for col in result.columns]
    result = result.transpose()
    result.to_csv(os.path.expanduser(args.output_file))
    
print("imputed count file saved to `%s`" % args.output_file)
