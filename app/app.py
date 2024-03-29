from flask import Flask, render_template, request
from flask import jsonify
from fastai import *
from fastai.vision import *
from flask_cors import CORS
from io import BytesIO

import json, pickle

app = Flask(__name__)
cors = CORS(app)
path = Path(__file__).parent

# Load the learner from export.pkl
learn = load_learner(f'{path}/models')

@app.route('/test')
def test():
    return jsonify({'data': 'great success'})

# POST route for prediction
@app.route('/predict', methods=['POST'])
def predict():
    data = request.files['data'].read()
    img = open_image(BytesIO(data))
    prediction, predictionClass, outputs = learn.predict(img)
    return jsonify({
        'prediction': str(prediction),
        'outputs': str(outputs)
    })

if __name__ == '__main__':
    if 'serve' in sys.argv:
        app.run(host='0.0.0.0', port=5044)
