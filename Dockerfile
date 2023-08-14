FROM python:3.10.10-slim-buster

WORKDIR /root/

ADD src ./ 

RUN  pip install Flask==2.1.2 && pip install pymongo==4.3.3 && pip install prometheus_client==0.16.0

ENV MONGO_URI=mongodb://mongo:27017/

CMD ["python", "./todo.py"]