


To create container of all the functions (the function app) :

```
func init function-app --worker-runtime node --language typescript
```

To create the new function (inside function-app/):

func new --name synchronization-function --language typescript --template "Azure Event Grid trigger" --worker-runtime node


We then build it (necessary step!)
```
npm run build
```

We deploy it (inside function-app/):
```
func azure functionapp publish dev-cqrs-function-app
```

After that we create the terraform subscription ( because it needs the function name )
