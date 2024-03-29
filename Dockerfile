FROM tensorflow/tensorflow:2.7.0rc1-gpu

RUN python --version

RUN gpg --keyserver keyserver.ubuntu.com --recv A4B469963BF863CC
RUN gpg --export --armor A4B469963BF863CC | apt-key add -

RUN echo '\
Acquire::Retries "100";\
Acquire::https::Timeout "240";\
Acquire::http::Timeout "240";\
APT::Get::Assume-Yes "true";\
APT::Install-Recommends "false";\
APT::Install-Suggests "false";\
Debug::Acquire::https "true";\
' > /etc/apt/apt.conf.d/99custom

RUN apt-get update && apt-get install -y \
    libsndfile1 \
    ffmpeg \
    git

RUN pip install --upgrade pip
RUN pip install --no-cache-dir \
    librosa \
    numpy \
    python-dotenv \
    yt-dlp \
    soundfile \
    prefect==2.14.11 \
    mlflow \
    boto3 

RUN mkdir -p /data
ENV TF_FORCE_GPU_ALLOW_GROWTH=true