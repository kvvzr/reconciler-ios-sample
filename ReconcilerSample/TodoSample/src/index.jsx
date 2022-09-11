const { register } = ReactBridge;
const { useState } = React;

const TodoItem = ({ title }) => {
  // これは雑なTODO管理
  const [done, setDone] = useState(false);

  return (
    <hstack>
      <toggle
        isOn={done}
        onChange={(value) => {
          setDone(value);
        }}
      />
      <text strike={done}>{title}</text>
    </hstack>
  );
};

register(() => {
  const [text, setText] = useState("");
  const [todos, setTodos] = useState([]);

  return (
    <vstack>
      <hstack>
        <textfield
          text={text}
          placeholder={"Todo"}
          onChange={(text) => {
            setText(text);
          }}
        />
        <button
          title={"Add"}
          onClick={() => {
            if (!text) {
              return;
            }
            setTodos([...todos, { title: text }]);
            setText("");
          }}
        />
      </hstack>
      <scroll>
        <vstack>
          {todos.map((todo) => {
            return <TodoItem title={todo.title} />;
          })}
        </vstack>
      </scroll>
    </vstack>
  );
});
