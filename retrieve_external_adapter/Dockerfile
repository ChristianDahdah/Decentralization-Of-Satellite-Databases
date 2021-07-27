FROM python:alpine3.7
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
COPY . /app
WORKDIR /app
RUN pip3 install pipenv
RUN pipenv install --system --deploy --ignore-pipfile
ENTRYPOINT [ "python" ]
CMD [ "app.py" ]
