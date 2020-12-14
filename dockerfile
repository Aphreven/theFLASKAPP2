FROM python:3.8.6

WORKDIR /app

COPY requirements.txt /app
RUN pip install -r requirements.txt

COPY . /app

ENV POSTGRES_PASSWORD=azerty
ENV POSTGRESS_USER=user
ENV POSTGRESS_DB=testdb

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh
ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

CMD ["python","app.py","runserver","--host=0.0.0.0","--threaded"]

