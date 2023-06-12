import java.util.ArrayList;

public class Items extends Sprite {
    
    ArrayList<Sprite> items = new ArrayList<Sprite>();
    String imageFile;
    String name;

    public Items(String imageFile, String name, int x, int y) {
        super(imageFile, x, y);
        this.imageFile = imageFile;
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void addItem(Sprite item) {
        items.add(item);
    }
}