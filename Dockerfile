FROM frolvlad/alpine-miniconda3

RUN echo "Install python packages" \
   && pip install -r requirements.txt

ENV app_dir /py_app

WORKDIR ${app_dir}

RUN mkdir ${app_dir}/output
RUN mkdir ${app_dir}/logs

RUN echo "export PYTHONPATH=${app_dir}/" >> ~/.bashrc

COPY . ${app_dir}/