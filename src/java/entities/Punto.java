/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author hugop
 */
@Entity
@Table(name = "PUNTO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Punto.findAll", query = "SELECT p FROM Punto p")
    , @NamedQuery(name = "Punto.findById", query = "SELECT p FROM Punto p WHERE p.id = :id")
    , @NamedQuery(name = "Punto.findByPuntos", query = "SELECT p FROM Punto p WHERE p.puntos = :puntos")})
public class Punto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "PUNTOS")
    private Short puntos;
    @JoinColumn(name = "PLAYA", referencedColumnName = "ID")
    @ManyToOne
    private Playa playa;
    @JoinColumn(name = "USUARIO", referencedColumnName = "ID")
    @ManyToOne
    private Usuario usuario;

    public Punto() {
    }

    public Punto(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Short getPuntos() {
        return puntos;
    }

    public void setPuntos(Short puntos) {
        this.puntos = puntos;
    }

    public Playa getPlaya() {
        return playa;
    }

    public void setPlaya(Playa playa) {
        this.playa = playa;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Punto)) {
            return false;
        }
        Punto other = (Punto) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Punto[ id=" + id + " ]";
    }
    
}
