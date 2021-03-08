FROM python:3.8-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
		gcc \
		libc-dev \
	&& rm -rf /var/lib/apt/lists/*

ADD . /
RUN pip3 install -r requirements.txt

# hotfix: https://github.com/Parallels/rq-dashboard/issues/362#issuecomment-716112353
RUN pip3 install rq==1.5.2

RUN python3 setup.py develop

EXPOSE 9181

ENTRYPOINT ["python3", "-m", "rq_dashboard"]
