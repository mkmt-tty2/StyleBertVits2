FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-runtime
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y build-essential libssl-dev libffi-dev cmake git wget ffmpeg nvidia-cuda-toolkit libatlas-base-dev gfortran git-lfs
RUN pip3 uninstall -y cmake
RUN git lfs install

WORKDIR /1
RUN git clone https://github.com/mkmt-tty2/StyleBertVits2.git
RUN mv StyleBertVits /app

WORKDIR /app/model_assets
RUN git clone https://huggingface.co/mkty/tsukuyomi

WORKDIR /app
RUN pip3 install -r requirements.txt
RUN pip3 install runpod
ENV LD_LIBRARY_PATH /opt/conda/lib/python3.10/site-packages/nvidia/cublas/lib:/opt/conda/lib/python3.10/site-packages/nvidia/cudnn/lib:${LD_LIBRARY_PATH}
RUN python initialize.py --skip_jvnv

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" /dev/null

RUN chmod +x start.sh

CMD [ "./start.sh" ]
