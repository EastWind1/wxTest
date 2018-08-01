package weixin.model;

public class User {
    private String id;

    private String photo_url;
    
    private String password;

    private String name;

    private String question;

    private String answer;
    
    private String state;
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getPassword() {
        return password;
    }
    
	public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }
	
    public String getPhoto_url() {
		return photo_url;
	}

	public void setPhoto_url(String photo_url) {
		this.photo_url = photo_url;
	}
	
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question == null ? null : question.trim();
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer == null ? null : answer.trim();
    }

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}


    
}