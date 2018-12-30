echo "building for R version ${rver-3.5.0}."
docker build --build-arg rver=${rver-3.5.0} -t moinfar/bio-r-base:${rver-3.5.0} .
