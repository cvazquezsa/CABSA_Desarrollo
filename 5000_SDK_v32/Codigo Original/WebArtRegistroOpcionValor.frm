
[Forma]
Clave=WebArtRegistroOpcionValor
Icono=0
Modulos=(Todos)
Nombre=Nuevo Detalle

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=680
PosicionInicialArriba=451
PosicionInicialAlturaCliente=140
PosicionInicialAncho=369
BarraHerramientas=S
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Nombre,Info.Nombre2)
ListaAcciones=(Lista)
VentanaSiempreAlFrente=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Centrado
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Temp.Texto
CarpetaVisible=S

[(Variables).Temp.Texto]
Carpeta=(Variables)
Clave=Temp.Texto
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S



















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
