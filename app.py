import dash
from dash import dcc, html
import plotly.graph_objs as go
import pandas as pd

# Initialisation de l'application Dash
app = dash.Dash(__name__)

app.layout = html.Div([
    html.H1("Dashboard de suivi TSLA"),
    dcc.Graph(id='live-graph'),
    # Un Interval pour rafraîchir le graphique toutes les 5 minutes (5*60*1000 ms)
    dcc.Interval(
        id='interval-component',
        interval=5*60*1000,  
        n_intervals=0
    )
])

@app.callback(
    dash.dependencies.Output('live-graph', 'figure'),
    [dash.dependencies.Input('interval-component', 'n_intervals')]
)
def update_graph(n):
    try:
        df = pd.read_csv("data.csv", names=["datetime", "price"])
    except Exception:
        df = pd.DataFrame(columns=["datetime", "price"])
    # Convertir la colonne price en numérique
    df["price"] = pd.to_numeric(df["price"], errors='coerce')
    data = go.Scatter(
        x=df["datetime"],
        y=df["price"],
        mode='lines+markers'
    )
    layout = go.Layout(
        title='Évolution du prix TSLA en temps réel',
        xaxis=dict(title='Date'),
        yaxis=dict(title='Prix')
    )
    return {'data': [data], 'layout': layout}

if __name__ == '__main__':
    # Pour que le dashboard soit accessible de l'extérieur, on écoute sur 0.0.0.0
    app.run_server(debug=True, host='0.0.0.0')
