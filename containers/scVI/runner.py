import os
import argparse
import pandas as pd


def parse_args():
    p = argparse.ArgumentParser(description='MAGIC', formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    p.add_argument('-i', '--input', metavar='FILE', default='input_count.csv', type=str,
                   help='File path of input data file.')
    p.add_argument('-o', '--outputdir', metavar='DIR', default='/output', type=str,
                   help='Directory which output should be stored in.')

    p.add_argument('-n', '--n-epochs', default=400, type=int,
                   help='number of epoch in training the NN.')
    p.add_argument('--lr', default=1e-3, type=float,
                   help='learning rate.')
    p.add_argument('-s', '--train-size', default=0.75, type=float,
                   help='faction of data used in training the NN.')

    try:
        return p.parse_args()
    except ArgumentParserError:
        raise


def make_sure_dir_exists(dire_name):
    import errno

    try:
        os.makedirs(dire_name)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise e


args = parse_args()
print("run with these parametres: %s" % str(args))


# Main Part

from scvi.dataset.csv import CsvDataset
from scvi.models import VAE
from scvi.inference import UnsupervisedTrainer

dataset = CsvDataset(args.input)
vae = VAE(dataset.nb_genes, n_batch=0)

trainer = UnsupervisedTrainer(vae,
                              dataset,
                              train_size=args.train_size,
                              use_cuda=False,
                              frequency=5)
trainer.train(n_epochs=args.n_epochs, lr=args.lr)

get_all_latent_and_imputed_values(save_imputed=True,
                                  filename_imputation=os.path.join(args.outputdir, "imputed_values.csv"),
                                  save_latent=True,
                                  filename_latent=os.path.join(args.outputdir, "latent.csv"))
