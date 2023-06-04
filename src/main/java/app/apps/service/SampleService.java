package app.apps.service;

import app.apps.dao.HibernateDAO;
import app.apps.model.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;

import java.util.List;

@Service
public class SampleService {
    @Autowired
    HibernateDAO hibernateDAO;
/* 
    public List<T> getAllActor() {
        return hibernateDAO.getAll1(new Actor());
    }

    public Actor getActorById(Integer id) throws Exception {
        return hibernateDAO.getById(new Actor(), id);
    }
 */
    public void generatePDF(Document document) throws Exception {/* 
        try {
            Font ftitre = new Font(Font.FontFamily.TIMES_ROMAN, 30, Font.BOLD, new BaseColor(0, 0, 0));
            Font sousTitre = new Font(Font.FontFamily.TIMES_ROMAN, 20, Font.ITALIC | Font.UNDERLINE,
                    new BaseColor(0, 0, 0));
            // couleur dialogue
            Font para1 = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.NORMAL, new BaseColor(0, 0, 0));
            // couleur des dialogues de l'actor
            Font para2 = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.NORMAL, new BaseColor(200, 80, 80));
            // couleur des dialogues de l'action'
            Font para3 = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.ITALIC, new BaseColor(0, 0, 0));

            // titre
            document.addTitle("Dialogues de " + actor.getName());
            Paragraph titre = null;
            Paragraph dialogueActor = null;
            Paragraph dialogueAction = null;
            for (Scene scene : scenes) {
                titre = new Paragraph("Scene: " + scene.getTitle(), ftitre);
                titre.setAlignment(1);
                document.add(titre);
                document.add(Chunk.NEWLINE);
                titre = new Paragraph("Global action: " + scene.getGlobal_action(), sousTitre);
                titre.setAlignment(1);
                document.add(titre);
                document.add(Chunk.NEWLINE);
                for (Dialogue dialogue : scene.getDialogues()) {
                    if (dialogue.getCharacter().getActor().getId() == actor.getId()) {
                        dialogueActor = new Paragraph(
                                dialogue.getCharacter().getName() + ": " + dialogue.getTexte(), para2);
                        dialogueActor.setIndentationLeft(40);
                        dialogueAction = new Paragraph(" (" + dialogue.getAction() + ")\n", para3);
                    } else {
                        dialogueActor = new Paragraph(
                                dialogue.getCharacter().getName() + ": " + dialogue.getTexte(), para1);
                        dialogueActor.setIndentationLeft(40);
                        dialogueAction = new Paragraph(" (" + dialogue.getAction() + ")\n", para3);
                    }
                    document.add(dialogueActor);
                    document.add(dialogueAction);
                }
                document.add(Chunk.NEWLINE);
            }
        } catch (Exception e) {
            throw new Exception("pdf rate");
        } */
    }
}
