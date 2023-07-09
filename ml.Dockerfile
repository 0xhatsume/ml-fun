FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel

RUN apt-get update && apt-get install -y --no-install-recommends \
        libsm6 \
        libxext6 \
        libxrender-dev \
        ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# git cmake 

RUN /opt/conda/bin/conda install -y pandas scikit-learn matplotlib seaborn jupyter jupyterlab && \
    /opt/conda/bin/conda install -c conda-forge tensorboardx && \
    /opt/conda/bin/conda clean -ya

# RUN /opt/conda/bin/conda install -y nodejs opencv Cython tensorflow pandas scikit-learn matplotlib seaborn jupyter jupyterlab && \
#     /opt/conda/bin/conda install -c conda-forge tensorboardx && \
#     /opt/conda/bin/conda clean -ya

# RUN jupyter labextension install jupyterlab_tensorboard

RUN pip install jupyter_tensorboard torchvision scikit-image streamlit

RUN mkdir -p /home/ml && chmod 1777 /home/ml

ENV HOME /home/ml

RUN pip install transformers sentencepiece

# # tensorboard
EXPOSE 6006
# # jupyter notebook
EXPOSE 8888

ENV JUPYTER_ALLOW_INSECURE_WRITES 1
CMD ["/bin/bash", "-c", "echo jupyter tensorboard enable --user;echo jupyter lab --no-browser --ip=0.0.0.0 --port=8888"]
#jupyter notebook --allow-root --ip=0.0.0.0 --port=8888