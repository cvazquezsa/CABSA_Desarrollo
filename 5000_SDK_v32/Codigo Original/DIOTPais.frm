
[Forma]
Clave=DIOTPais
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=DPIVA - Pais

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=349
PosicionInicialAncho=509
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=428
PosicionInicialArriba=170
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTPais
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=País
[Lista.DIOTPais.Pais]
Carpeta=Lista
Clave=DIOTPais.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.DIOTPais.Nacionalidad]
Carpeta=Lista
Clave=DIOTPais.Nacionalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

GuardarAntes=S
[Lista.Columnas]
Pais=110
Nacionalidad=304





Clave=45
[Lista.ListaEnCaptura]
(Inicio)=DIOTPais.Pais
DIOTPais.Pais=DIOTPais.Nacionalidad
DIOTPais.Nacionalidad=DIOTPais.Clave
DIOTPais.Clave=(Fin)

[Lista.DIOTPais.Clave]
Carpeta=Lista
Clave=DIOTPais.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco
