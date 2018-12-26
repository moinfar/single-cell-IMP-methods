library(optparse)
library(readr)
library(VIPER)

option_list = list(
  make_option(c("-i", "--input"), type="character", default="input_count.csv", help="input count file to be imputed [default= %default]", metavar="character"),
  make_option(c("-o", "--output"), type="character", default="imputed_count.csv", help="file which output should be stored in [default= %default]", metavar="character"),
  make_option(c("--num"), type="integer", default=5000, help="number of random sampled genes used to fit the penalized regression model to identify the set of candidate cells [default= %default]", metavar="integer"),
  make_option(c("--percentage_cutoff"), type="double", default=0.1, help="threshold set on zero rate of genes [default= %default]", metavar="double"),
  make_option(c("--alpha"), type="double", default=1, help="sets the elastic net mixing parameter [default= %default]", metavar="double")
);


opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);


input_file = file.path("/data", opt$input)
if(!file.exists(input_file)) {
  stop(paste0("File `", input_file, "` not exists. Did you mount `/data` volume into docker?"))
}

gene_expression = read.csv(input_file)

res <- VIPER(gene.expression, 
             num = opt$num, 
             percentage.cutoff = opt$percentage_cutoff, 
             minbool = FALSE, 
             alpha = opt$alpha)
write.csv(res, file.path("/data", opt$output))