FROM public.ecr.aws/lambda/python:3.8

# Copy function code
COPY ./ ${LAMBDA_TASK_ROOT}/
COPY requirements.pip  .

# Give user / group permission to run python files
RUN chmod -R 755 ${LAMBDA_TASK_ROOT} && \
    pip3 install -r requirements.pip --target "${LAMBDA_TASK_ROOT}"

# COPY connectors/ ${LAMBDA_TASK_ROOT}/connectors
# COPY controllers/person_controller.py ${LAMBDA_TASK_ROOT}/controllers/person_controller.py
# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "main.handler" ]