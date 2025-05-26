FROM r-base:latest

WORKDIR /app

COPY requirements.R .

RUN Rscript requirements.R

CMD ["bash"]
