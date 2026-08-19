const MODO = {
  focus: { seconds: 25 * 60, color: "--accent-focus", label: "Enfoque" },
  short: { seconds: 5 * 60, color: "--accent-short", label: "Descanso corto" },
};

const RUEDITA = 2 * Math.PI * 90;

const tiempo = document.getElementById("tiempo");
const pausa = document.getElementById("pausa");
const reinicio = document.getElementById("reinicio");
const contador = document.getElementById("ciclos");
const progreso = document.querySelector(".ring-progress");
const modeButtons = document.querySelectorAll(".mode-btn");

let currentMode = "focus";
let secondsLeft = MODO[currentMode].seconds;
let totalSeconds = MODO[currentMode].seconds;
let timerId = null;
let isRunning = false;
const CICLOS_KEY = "pomodoro-ciclos";
let ciclos = Number(localStorage.getItem(CICLOS_KEY)) || 0;
contador.textContent = ciclos;

progreso.style.strokeDasharray = RUEDITA;

function formatTime(seconds) {
  const m = Math.floor(seconds / 60).toString().padStart(2, "0");
  const s = Math.floor(seconds % 60).toString().padStart(2, "0");
  return `${m}:${s}`;
}

function updateDisplay() {
  tiempo.textContent = formatTime(secondsLeft);
  const offset = RUEDITA * (1 - secondsLeft / totalSeconds);
  progreso.style.strokeDashoffset = offset;
}

function setMode(mode) {
  currentMode = mode;
  totalSeconds = MODO[mode].seconds;
  secondsLeft = totalSeconds;
  document.documentElement.style.setProperty(
    "--accent",
    `var(${MODO[mode].color})`
  );
  modeButtons.forEach((btn) =>
    btn.classList.toggle("active", btn.dataset.mode === mode)
  );
  pauseTimer();
  updateDisplay();
}

function tick() {
  secondsLeft--;
  updateDisplay();
  if (secondsLeft <= 0) {
    pauseTimer();
    handleCompletion();
  }
}

function startTimer() {
  if (isRunning) return;
  isRunning = true;
  pausa.textContent = "Pausar";
  timerId = setInterval(tick, 1000);
}

function pauseTimer() {
  isRunning = false;
  pausa.textContent = "Iniciar";
  clearInterval(timerId);
  timerId = null;
}

function resetTimer() {
  pauseTimer();
  secondsLeft = totalSeconds;
  updateDisplay();
  ciclos = 0;
  contador.textContent = ciclos;
  localStorage.removeItem(CICLOS_KEY);
}

function handleCompletion() {
  if (currentMode === "focus") {
    ciclos++;
    contador.textContent = ciclos;
    localStorage.setItem(CICLOS_KEY, ciclos);
    setMode("short");
  } else {
    setMode("focus");
  }
  startTimer();
}

pausa.addEventListener("click", () => {
  isRunning ? pauseTimer() : startTimer();
});

reinicio.addEventListener("click", resetTimer);

modeButtons.forEach((btn) => {
  btn.addEventListener("click", () => setMode(btn.dataset.mode));
});

setMode("focus");

const TAREAS_KEY = "pomodoro-tareas";
const formTarea = document.getElementById("form-tarea");
const inputTarea = document.getElementById("input-tarea");
const listaTareas = document.getElementById("lista-tareas");

let tareas = JSON.parse(localStorage.getItem(TAREAS_KEY)) || [];

function guardarTareas() {
  localStorage.setItem(TAREAS_KEY, JSON.stringify(tareas));
}

function renderTareas() {
  listaTareas.innerHTML = "";
  tareas.forEach((tarea, index) => {
    const li = document.createElement("li");
    li.className = "task-item" + (tarea.done ? " done" : "");

    const span = document.createElement("span");
    span.textContent = tarea.text;
    span.addEventListener("click", () => {
      tarea.done = !tarea.done;
      guardarTareas();
      renderTareas();
    });

    const btnEliminar = document.createElement("button");
    btnEliminar.textContent = "x";
    btnEliminar.type = "button";
    btnEliminar.addEventListener("click", () => {
      tareas.splice(index, 1);
      guardarTareas();
      renderTareas();
    });

    li.append(span, btnEliminar);
    listaTareas.appendChild(li);
  });
}

formTarea.addEventListener("submit", (e) => {
  e.preventDefault();
  const texto = inputTarea.value.trim();
  if (!texto) return;
  tareas.push({ text: texto, done: false });
  guardarTareas();
  renderTareas();
  inputTarea.value = "";
  inputTarea.focus();
});

renderTareas();
