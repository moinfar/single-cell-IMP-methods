import os
import argparse

import numpy as np
import pandas as pd

from uncurl import max_variance_genes, run_state_estimation


parser = argparse.ArgumentParser(description='A docker wrapper around UNCURL.', formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument("-i", "--input", type=str, default="input_count.csv", help="input count file to be imputed", metavar="FILE")
parser.add_argument("-o", "--output", type=str, default="imputed_count.csv", help="file which output should be stored in", metavar="FILE")
parser.add_argument("--gene_subset", type=str, default="non_zero", help="subset of genes used in algorithm (non_zero/max_variance)", metavar="STRING")
parser.add_argument("--clusters", type=int, default=10, help="number of clusters", metavar="INT")
parser.add_argument("--dist", type=str, default="Poiss", help="distribution model (Poiss/LogNorm/Gaussian/NB)", metavar="STRING")
parser.add_argument("--max_iters", type=int, default=30, help="max_iters parameter", metavar="INT")
parser.add_argument("--inner_max_iters", type=int, default=100, help="inner_max_iters parameter", metavar="INT")
parser.add_argument("--initialization", type=str, default="tsvd", help="initialization", metavar="STRING")
parser.add_argument("--threads", type=int, default=8, help="number of threads", metavar="INT")
parser.add_argument("-v", "--verbose", action="store_true", default=False)

args = parser.parse_args()

print("run with these parametres: %s" % str(args))

input_file = os.path.join("/data", args.input)
if not os.path.exists(input_file):
        raise Exception("File `%s` not exists. Did you mount `/data` volume into docker?" % input_file)

data = pd.read_csv(input_file, index_col=0)

if args.gene_subset == 'non_zero':
    genes_subset = max_variance_genes(data.values, nbins=5, frac=0.2) # select genes with max variance
elif args.gene_subset == 'max_variance':
    genes_subset = np.sum(data.values, axis=1) != 0  # select nonzero genes
else:
    raise NotImplementedError("optin `%s` for `gene_subset` not defined." % args.gene_subset)
    
data_subset = data.iloc[genes_subset,:]
M, W, ll = run_state_estimation(data_subset.values, clusters=args.clusters, dist=args.dist, disp=args.verbose, max_iters=args.max_iters, inner_max_iters=args.inner_max_iters, initialization=args.initialization, threads=args.threads)

print("ll: %f" % ll)

data.iloc[genes_subset, :] = np.matmul(M, W) # imputation

output_addr = os.path.join("/data", args.output)
data.to_csv(output_addr)
print("imputed count file saved to `%s`" % output_addr)
