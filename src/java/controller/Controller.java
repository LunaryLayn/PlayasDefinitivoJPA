package controller;

import entities.Ccaa;
import entities.Municipio;
import entities.Playa;
import entities.Provincia;
import entities.Punto;
import entities.PuntoView;
import entities.Usuario;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import util.JPAUtil;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Query q;
        List<Ccaa> comunidades;
        List<Provincia> provincias;
        List<Municipio> municipios;
        List<Playa> playas;
        Usuario usuario = null;
        
        EntityManager em = (EntityManager) session.getAttribute("em");
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }

        String op = request.getParameter("op");
        if (op.equals("inicio")) {
            
            q = em.createQuery("SELECT c FROM Ccaa c");
            comunidades = q.getResultList();
            session.setAttribute("comunidades", comunidades);
            
            session.removeAttribute("provincias");
            session.removeAttribute("municipios");
            session.removeAttribute("playas");
            session.removeAttribute("usuario");
            session.removeAttribute("cbprovincia");
            session.removeAttribute("cbmunicipio");
            session.removeAttribute("cbcomunidad");
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
            
        } else if (op.equals("getprovincias")) {
            String cbcomunidad = request.getParameter("cbcomunidad");
            comunidades = (List<Ccaa>) session.getAttribute("comunidades");
            Ccaa selCom = comunidades.get(Integer.parseInt(cbcomunidad));
            provincias = selCom.getProvinciaList();
            session.setAttribute("provincias", provincias);
            session.setAttribute("cbcomunidad", cbcomunidad);
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        
        else if (op.equals("getmunicipios")) {
            String cbprovincia = request.getParameter("cbprovincia");
            provincias = (List<Provincia>) session.getAttribute("provincias");
            Provincia prov = provincias.get(Integer.parseInt(cbprovincia));
            municipios = prov.getMunicipioList();
            session.setAttribute("municipios", municipios);
            session.setAttribute("cbprovincia", cbprovincia);
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        else if (op.equals("getplayas")) {
            String cbmunicipio = request.getParameter("cbmunicipio");
            municipios = (List<Municipio>)session.getAttribute("municipios");
            Municipio mun = municipios.get(Integer.parseInt(cbmunicipio));
            playas = mun.getPlayaList();
            session.setAttribute("playas", playas);
            session.setAttribute("cbmunicipio", cbmunicipio);
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        
        else if (op.equals("login")) {
            String nick = request.getParameter("nick");
            String pass = request.getParameter("pass");
            
            q = em.createQuery("SELECT u FROM Usuario u WHERE u.nick = '"+nick+"' AND u.pass = '"+pass+"'");
            try {
                usuario = (Usuario) q.getSingleResult();
            } catch (Exception e) {
                System.out.println("Usuario no existe");
            }
            
            if(usuario==null) {
                usuario = new Usuario();
                usuario.setNick(nick);
                usuario.setPass(pass);
                EntityTransaction t = em.getTransaction();
                t.begin();
                em.persist(usuario);
                t.commit();
            }
            session.setAttribute("usuario", usuario);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        
        else if (op.equals("logout")) {
            session.removeAttribute("usuario");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        else if (op.equals("detail")) {
            String playaid = request.getParameter("det");
            q = em.createQuery("SELECT p FROM Playa p WHERE p.id ='"+playaid+"'");
            Playa playa = (Playa) q.getSingleResult();
            
            int puntuacion = 0;
            
            List<Punto> puntos = playa.getPuntoList();
            float sum = 0;
            int sumasiones=0;
            for(Punto punto : puntos) {
               sum += punto.getPuntos();
               sumasiones++;
            }
            
            puntuacion = (int) Math.round(sum/sumasiones);
            
            session.setAttribute("playa", playa);
            session.setAttribute("puntuacion", puntuacion);
            
            request.getRequestDispatcher("detail.jsp").forward(request, response);
        }
        else if (op.equals("savePuntuacion")) {
            String puntos = request.getParameter("puntos");
            Playa playa = (Playa) session.getAttribute("playa");
            usuario = (Usuario) session.getAttribute("usuario");
            
            Punto punto = new Punto(1);
            punto.setPuntos(Short.valueOf(puntos));
            punto.setPlaya(playa);
            punto.setUsuario(usuario);
            EntityTransaction t = em.getTransaction();
            t.begin();
            em.persist(punto);
            t.commit();
            playa = em.find(Playa.class, playa.getId());
            session.setAttribute("playa", playa);
            session.setAttribute("msg", "Anotado "+puntos+" puntos a "+playa.getNombre());
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        
        else if (op.equals("puntuacion")) {
            String idplaya = request.getParameter("idplaya");
            q=em.createQuery("select p.puntos, count(p.puntos) from Punto p where p.playa.id="+idplaya+" group by p.puntos order by p.puntos");
            
            List<Object[]> resultList = q.getResultList();
            List<PuntoView> puntuaciones = new ArrayList<>();
            for (Object[] row : resultList) {
                puntuaciones.add(new PuntoView((Short) row[0], (Long)row[1]));
            }
            request.setAttribute("puntuaciones", puntuaciones);
            
            request.getRequestDispatcher("puntuacion.jsp").forward(request, response);
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
