echo "building for python version ${pyver-3.5}."
docker build --squash --build-arg pyver=${pyver-3.5} -t moinfar/bio-py-base:${pyver-3.5} .
