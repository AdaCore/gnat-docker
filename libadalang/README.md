# Steps to Build Image
1. Download a linux x86-64 libadalang distribution that corresponds to the version of gnatpro you have build an image for. Place it in this directory
2. Update the first line of the dockerfile so the tag matches the gnatpro image that should be used. e.g. ```gnatpro:22.1```
3. Prepare your docker build command
   - An example command may look like:
      ```
      docker build \
         -t libadalang:latest \
         -t libadalang:22.1 \
         --build-arg LAL_RELEASE=libadalang-22.1-x86_64-linux-bin.tar.gz \
         .
      ```
   - For `--build-arg LAL_RELEASE=` argument you should provide the name of the libadalang tar.gz that you downloaded in step 1
4. Run your docker build command