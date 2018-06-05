
[Forma]
Clave=NomTabFirmas
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Nomina Tabular Firmas
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Inicio
CarpetaPrincipal=Inicio
ListaAcciones=Cerrar
PosicionInicialIzquierda=359
PosicionInicialArriba=157
PosicionInicialAlturaCliente=177
PosicionInicialAncho=500
[Inicio]
Estilo=Ficha
Clave=Inicio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomTabFirmas
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Inicio.NomTabFirmas.ElaNombre]
Carpeta=Inicio
Clave=NomTabFirmas.ElaNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Inicio.NomTabFirmas.ElaPuesto]
Carpeta=Inicio
Clave=NomTabFirmas.ElaPuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Inicio.NomTabFirmas.AutNombre]
Carpeta=Inicio
Clave=NomTabFirmas.AutNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco

[Inicio.NomTabFirmas.AutPuesto]
Carpeta=Inicio
Clave=NomTabFirmas.AutPuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Inicio.ListaEnCaptura]
(Inicio)=NomTabFirmas.ElaNombre
NomTabFirmas.ElaNombre=NomTabFirmas.ElaPuesto
NomTabFirmas.ElaPuesto=NomTabFirmas.AutNombre
NomTabFirmas.AutNombre=NomTabFirmas.AutPuesto
NomTabFirmas.AutPuesto=(Fin)
