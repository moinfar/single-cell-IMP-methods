echo "Testing dca-cpu ..."
bash ../run_scripts/dca-cpu.sh cell_cycle_hvg.csv ./ignore/dca-cpu-output.csv ./ignore/dca-cpu-output.d
if [ ! -f ./ignore/dca-cpu-output.d/time.txt ]; then echo "dca-cpu >> time.txt not found"; fi

echo "Testing decode ..."
bash ../run_scripts/decode.sh cell_cycle_hvg.csv ./ignore/decode-output.csv ./ignore/decode-output.d
if [ ! -f ./ignore/decode-output.d/time.txt ]; then echo "decode >> time.txt not found"; fi

echo "Testing deepimpute ..."
bash ../run_scripts/deepimpute.sh cell_cycle_hvg.csv ./ignore/deepimpute-output.csv ./ignore/deepimpute-output.d
if [ ! -f ./ignore/deepimpute-output.d/time.txt ]; then echo "deepimpute >> time.txt not found"; fi

echo "Testing drimpute ..."
bash ../run_scripts/drimpute.sh cell_cycle_hvg.csv ./ignore/drimpute-output.csv ./ignore/drimpute-output.d
if [ ! -f ./ignore/drimpute-output.d/time.txt ]; then echo "drimpute >> time.txt not found"; fi

echo "Testing knn-smoothing ..."
bash ../run_scripts/knn-smoothing.sh cell_cycle_hvg.csv ./ignore/knn-smoothing-output.csv ./ignore/knn-smoothing-output.d
if [ ! -f ./ignore/knn-smoothing-output.d/time.txt ]; then echo "knn-smoothing >> time.txt not found"; fi

echo "Testing magic ..."
bash ../run_scripts/magic.sh cell_cycle_hvg.csv ./ignore/magic-output.csv ./ignore/magic-output.d
if [ ! -f ./ignore/magic-output.d/time.txt ]; then echo "magic >> time.txt not found"; fi

echo "Testing netsmooth ..."
bash ../run_scripts/netsmooth.sh cell_cycle_hvg.csv ./ignore/netsmooth-output.csv ./ignore/netsmooth-output.d
if [ ! -f ./ignore/netsmooth-output.d/time.txt ]; then echo "netsmooth >> time.txt not found"; fi

echo "Testing saucie ..."
bash ../run_scripts/saucie.sh cell_cycle_hvg.csv ./ignore/saucie-output.csv ./ignore/saucie-output.d
if [ ! -f ./ignore/saucie-output.d/time.txt ]; then echo "saucie >> time.txt not found"; fi

echo "Testing saver ..."
bash ../run_scripts/saver.sh cell_cycle_hvg.csv ./ignore/saver-output.csv ./ignore/saver-output.d
if [ ! -f ./ignore/saver-output.d/time.txt ]; then echo "saver >> time.txt not found"; fi

echo "Testing scimpute ..."
bash ../run_scripts/scimpute.sh cell_cycle_hvg.csv ./ignore/scimpute-output.csv ./ignore/scimpute-output.d
if [ ! -f ./ignore/scimpute-output.d/time.txt ]; then echo "scimpute >> time.txt not found"; fi

echo "Testing scvi-cpu ..."
bash ../run_scripts/scvi-cpu.sh cell_cycle_hvg.csv ./ignore/scvi-cpu-output.csv ./ignore/scvi-cpu-output.d
if [ ! -f ./ignore/scvi-cpu-output.d/time.txt ]; then echo "scvi-cpu >> time.txt not found"; fi

echo "Testing uncurl ..."
bash ../run_scripts/uncurl.sh cell_cycle_hvg.csv ./ignore/uncurl-output.csv ./ignore/uncurl-output.d
if [ ! -f ./ignore/uncurl-output.d/time.txt ]; then echo "uncurl >> time.txt not found"; fi

echo "Testing zinbwave ..."
bash ../run_scripts/zinbwave.sh cell_cycle_hvg.csv ./ignore/zinbwave-output.csv ./ignore/zinbwave-output.d
if [ ! -f ./ignore/zinbwave-output.d/time.txt ]; then echo "zinbwave >> time.txt not found"; fi

echo "Testing biscuit ..."
bash ../run_scripts/biscuit.sh cell_cycle_hvg.csv ./ignore/biscuit-output.csv ./ignore/biscuit-output.d  --num_cells_batch 100
if [ ! -f ./ignore/biscuit-output.d/time.txt ]; then echo "biscuit >> time.txt not found"; fi

