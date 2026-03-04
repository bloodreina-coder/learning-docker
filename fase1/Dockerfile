FROM python:3.9-slim
WORKDIR /app
COPY requirements .
RUN pip install --no-cache-dir -r requirements
COPY app.py .
EXPOSE 8080
CMD [ "python", "app.py" ]