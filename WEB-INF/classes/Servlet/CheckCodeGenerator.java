package Servlet;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

public class CheckCodeGenerator extends HttpServlet {
    private final int width=100;
    private final int height=40;
    private final int codeCount=4;

    private int fontHeight=0;
    private int codeX=0;
    private int codeY=0;

    char[] codeSequence="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789".toCharArray();

    public void init() throws ServletException {
        fontHeight=height-5;
        codeX=width/(codeCount+2);
        codeY=height-6;
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        BufferedImage bufferedImage=null;
        bufferedImage=new BufferedImage(width,height,BufferedImage.TYPE_3BYTE_BGR);

        Graphics2D graphics2D=null;
        graphics2D=bufferedImage.createGraphics();

        graphics2D.setColor(Color.darkGray);
        graphics2D.fillRect(0,0,width,height);

        Font font=null;
        font=new Font("",Font.BOLD,fontHeight);
        graphics2D.setFont(font);

        graphics2D.setColor(Color.gray);
        graphics2D.drawRect(0,0,width-1,height-1);

        Random random=null;
        random=new Random();
        graphics2D.setColor(Color.orange);
        for(int i=0;i<20;i++){
            int x=random.nextInt(width);
            int y=random.nextInt(height);
            int x1=random.nextInt(20);
            int y1=random.nextInt(30);
            graphics2D.drawLine(x,y,x+x1,y+y1);
        }

        StringBuilder randomCode = new StringBuilder();
        for(int i=0;i<codeCount;i++){
            char c=codeSequence[random.nextInt(codeSequence.length)];
            randomCode.append(c);
            graphics2D.setColor(Color.pink);
            graphics2D.drawString(String.valueOf(c),codeX*(i+1),codeY);
        }

        req.getSession().setAttribute("checkCode",randomCode.toString());

        graphics2D.dispose();
        final java.io.OutputStream os = res.getOutputStream();
        // 输出图象到页面
        ImageIO.write(bufferedImage, "PNG", os);
        os.flush();
        os.close();

    }
}
