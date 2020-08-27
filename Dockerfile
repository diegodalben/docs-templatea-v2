FROM python:3.8
COPY . /docs
WORKDIR /docs
RUN pip install mkdocs
EXPOSE 8000
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]