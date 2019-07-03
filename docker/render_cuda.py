import os
import sys
import subprocess

from jinja2 import Template

# Make sure that the cudnn version you set here is available
# for all the cuda versions that you want both from nvidia
# and from conda.

# These two must be in sync
CUDNN_FULL_VERSION = '7.6.0.64'
CUDNN_VERSION = '7.6.0'


condadir = os.path.dirname(sys.argv[0])
condadir = os.path.abspath(condadir)


with open(os.path.join(condadir, 'Dockerfile.conda_cuda.template')) as f:
    docker_template = Template(f.read())


def render_dockerfile(version):
    txt = docker_template.render(cuda_version=version,
                                 cudnn_short_version=CUDNN_VERSION,
                                 cudnn_version=CUDNN_FULL_VERSION)
    fname = os.path.join(condadir,
                         'Dockerfile.conda_cuda' + version.replace('.', ''))
    with open(fname, 'w') as f:
        f.write(txt)
    return fname


if __name__ == '__main__':
    build_versions = sys.argv[1:]
    for version in build_versions:
        render_dockerfile(version)
