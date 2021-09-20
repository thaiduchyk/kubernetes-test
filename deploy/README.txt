1. Create new cluster using AWS console

2. Add nodes to cluster using AWS console

3. Configure kubectl to connect to EKS cluster:
   - aws eks update-kubeconfig --name cluster_name

4. Create deployments
   - kubectl apply -f deploy/deployment.web.yml
   - kubectl apply -f deploy/deployment.worker.yml

5. Verify the deployment was successful:

   - kubectl rollout status deployments shipyard-web

5. Create service
   - kubectl apply -f deploy/service.web.yml

6. Edit Route 53 A record to new LoadBalancer



Deploy new app version:

1. Update docker image

2. Push image to repository

3. Update image version in deploy/deployment.web.yml

4. Apply changes to deployment:
   - kubectl apply -f deploy/deployment.web.yml

OR
  set new version of image:
  - kubectl set image deployments/shipyard-web webserver=thaiduchyk/shipyard:1.0.0


kubectl rollout history deployment shipyard-web


