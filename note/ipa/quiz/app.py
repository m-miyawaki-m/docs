from flask import Flask, jsonify, request
import pandas as pd

app = Flask(__name__)
data = pd.read_csv('questions.csv')  # CSVファイルをロード

@app.route('/questions', methods=['GET'])
def get_questions():
    page = int(request.args.get('page', 1))
    per_page = 10
    start = (page - 1) * per_page
    end = start + per_page
    questions = data.iloc[start:end].to_dict(orient='records')
    return jsonify(questions)

if __name__ == '__main__':
    app.run(debug=True)
