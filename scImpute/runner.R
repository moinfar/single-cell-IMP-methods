
library("optparse")

option_list = list(
    make_option(c("-i", "--input"), type="character", default="input_count.csv", help="input count file to be imputed [default= %default]", metavar="character"),
	make_option(c("-o", "--output"), type="character", default="imputed_count.csv", help="file which output should be stored in [default= %default]", metavar="character"),
	make_option(c("--drop_thre"), type="double", default=0.5, help="threshold set on dropout probability [default= %default]", metavar="double"),
    make_option(c("--Kcluster"), type="integer", default=2, help="number of cell subpopulations for the algorithm [default= %default]", metavar="integer"),
    make_option(c("--ncores"), type="integer", default=10, help="number of cores used in parallel computation [default= %default]", metavar="integer")
);


opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);


input_file = file.path("/data", opt$input)
if(!file.exists(input_file)) {
    stop(paste0("File `", input_file, "` not exists. Did you mount `/data` volume into docker?"))
}
dir.create("./scimpute_results/")


library(scImpute)


scimpute(count_path = input_file,
         infile = "csv",
         outfile = "csv",
         out_dir = "./scimpute_results/",
         labeled = FALSE,
         drop_thre = opt$drop_thre,
         Kcluster = opt$Kcluster,
         ncores = opt$ncores)


file.copy("./scimpute_results/scimpute_count.csv", 
          file.path("/data", opt$output))
