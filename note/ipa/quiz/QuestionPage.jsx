import React, { useState } from "react";

const QuestionPage = ({ questions }) => {
  const [visibleDescriptions, setVisibleDescriptions] = useState([]);

  const toggleDescription = (index) => {
    setVisibleDescriptions((prev) =>
      prev.includes(index)
        ? prev.filter((i) => i !== index)
        : [...prev, index]
    );
  };

  return (
    <div>
      {questions.map((question, index) => (
        <div key={index} style={{ borderBottom: "1px solid #ccc", padding: "10px" }}>
          <p><strong>Category:</strong> {question.category}</p>
          <p><strong>Term:</strong> {question.term}</p>
          <p><strong>Cite:</strong> {question.cite}</p>
          {visibleDescriptions.includes(index) ? (
            <div>
              <p style={{ whiteSpace: "pre-wrap" }}>{question.description}</p>
              <button onClick={() => toggleDescription(index)}>答えを非表示</button>
            </div>
          ) : (
            <button onClick={() => toggleDescription(index)}>答えを見る</button>
          )}
          <button>OK</button>
          <button>NG</button>
        </div>
      ))}
    </div>
  );
};

export default QuestionPage;
