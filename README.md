
# 📱 MediaStream Insights

Welcome to **MediaStream Insights!** This project is dedicated to building intelligent tools and services for processing photos and videos from iPhone and Android devices.

While Jupyter Notebooks are used for initial experimentation with local media processing—enhancing images, extracting audio, transcribing content, and deriving actionable insights from visual and audio data—our ultimate goal is to deploy these capabilities to the cloud. Let’s guide you through setting up your environment and installing the necessary libraries to begin contributing to the project!

## 📝 Project Structure

```
.
├── local/                      # Place local video files here
│   ├── hello.mov               # Example video file
├── notebooks/                  # Jupyter notebooks and requirements
│   ├── requirements_notebooks.txt    # List of required libraries
│   └── video_to_text.ipynb     # Notebook to process video to text
├── scripts/                    # Helper scripts for setup
│   └── run_notebook.sh         # Script to run Jupyter notebook
└── temp/                       # Temporary files (audio, etc.)
```

## 🚀 Getting Started

### 1. Prerequisites

- **Python**: Make sure you have Python 3.12+ installed.
- **Homebrew (for macOS users)**: To install `ffmpeg`, run:
    ```bash
    brew install ffmpeg
    ```
- **Windows**: If you are using Windows, you can download `ffmpeg` from the [official site](https://ffmpeg.org/download.html) and follow the installation instructions.

### 2. Install Dependencies

1. **Create a Virtual Environment**  
   You can either use the provided script to set up the environment or do it manually.

    - **Option 1: Automatic Setup**  
      Run the setup script:
      ```bash
      ./scripts/run_notebook.sh
      ```
      This script will:
      - Create a virtual environment inside the `notebooks/venv_notebooks` directory.
      - Install required dependencies.
      - Set up Jupyter with the necessary environment.

    - **Option 2: Manual Setup**  
      Alternatively, you can manually create a virtual environment and install the dependencies:
      ```bash
      # Create the virtual environment
      python3 -m venv notebooks/venv_notebooks

      # Activate the virtual environment
      source notebooks/venv_notebooks/bin/activate  # On Windows, use notebooks\venv_notebooks\Scripts\activate

      # Upgrade pip and install the necessary libraries
      pip install --upgrade pip
      pip install -r notebooks/requirements_notebooks.txt

      # Install Jupyter Kernel
      python -m ipykernel install --user --name="companion.notebooks" --display-name="Companion Notebooks"
      ```

### 3. Configure Environment Variables

1. **Create a `.env` file** in the project’s root directory (where the `.gitignore` is located). This file will store sensitive data like API keys and will not be uploaded to GitHub.

    Example `.env` file:
    ```bash
    OPENAI_API_KEY=your_openai_api_key
    ```

2. **Ensure that `.env` is correctly loaded** by the script when you run the notebook.

### 4. Strip Out Sensitive Data from Jupyter Notebooks

To prevent sensitive information (such as API keys) from being committed to GitHub, we use `nbstripout`.

1. **Install nbstripout**:
   ```bash
   pip install nbstripout
   ```

2. **Enable it for your repository**:
   ```bash
   nbstripout --install
   ```

   This will ensure that sensitive or heavy data is stripped out from the Jupyter notebooks before committing to GitHub.

### 5. Running the Notebook

To start processing a video and transcribe the audio:

1. **Activate the Virtual Environment**:
   ```bash
   source notebooks/venv_notebooks/bin/activate
   ```

2. **Run Jupyter Notebooks**:
   ```bash
   jupyter notebook
   ```

   Open the `video_to_text.ipynb` notebook and follow the steps inside.

---

## 🛠 Troubleshooting

- **`ffmpeg` not found**: Ensure that `ffmpeg` is installed and added to your system’s PATH. If you're on Windows, you may need to manually configure `ffmpeg` in your environment.
  
- **API Errors**: Double-check your `.env` file to make sure your OpenAI API key is set correctly.

---

## 🌟 Contributing

We encourage contributions! Please feel free to submit pull requests or issues. Before you push your code:

- Run `nbstripout` to ensure no sensitive data is accidentally committed.
- Ensure that your code follows the project’s structure and is well-documented.

Thank you for contributing to this project!

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

By following these steps, users will be able to set up the environment, process videos locally, and contribute seamlessly without worrying about leaking sensitive information into the repository.