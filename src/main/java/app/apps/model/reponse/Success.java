package app.apps.model.reponse;

public class Success {
    private Object data;
    private String message;

    public Success() {
    }

    public Success(Object data) {
        this.data = data;
    }
    
    public Success(String data) {
        this.data = data;
    }

    public Success(Object data, String message) {
        this.data = data;
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
