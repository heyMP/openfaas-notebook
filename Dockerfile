FROM openfaas/classic-watchdog:0.13.4 as watchdog

FROM psuastro528/notebook

USER root

COPY jupyter_notebook_config.json .jupyter/jupyter_notebook_config.json
COPY .lock /tmp/.lock

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

# Populate example here - i.e. "cat", "sha512sum" or "node index.js"
ENV fprocess="cat"
# Set to true to see request in function logs
ENV write_debug="false"

USER jovyan

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1