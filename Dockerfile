FROM public.ecr.aws/amazonlinux/amazonlinux:2023-minimal

# aarch64: Mac con Apple Silicon o PC con Arm. x86_64: Mac con Intel o PC x86_64.
ARG ARCH=aarch64

ADD https://downloads.aws.com/aws-emulator/packages/aws-emulator/LTS/latest/aws-emulator-${ARCH}.rpm /tmp/aws-emulator.rpm
RUN rpm -i /tmp/aws-emulator.rpm && rm /tmp/aws-emulator.rpm \
    && mkdir -p /home/emulator && chown 1000 /home/emulator
USER 1000
ENV HOME=/home/emulator
EXPOSE 9297
ENTRYPOINT ["aws-emulator", "-b", "0.0.0.0"]
