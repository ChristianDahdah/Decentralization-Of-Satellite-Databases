FROM python:alpine3.7
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
COPY . /web_server
WORKDIR /web_server
RUN pip3 install pipenv
RUN pipenv install --system --deploy --ignore-pipfile
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
