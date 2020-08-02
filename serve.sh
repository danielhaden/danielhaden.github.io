#!/bin/sh
docker run -v C:\Users\hadend\WebstormProjects\danielhaden.github.io:\tmp -p 4000:4000 jekyll jekyll serve -s /tmp --host 0.0.0.0 --incremental
