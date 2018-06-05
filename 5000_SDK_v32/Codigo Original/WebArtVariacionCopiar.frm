
[Forma]
Clave=WebArtVariacionCopiar
Icono=0
Modulos=(Todos)
Nombre=Nueva Variación
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal

ListaCarpetas=Variables
CarpetaPrincipal=Variables
PosicionInicialIzquierda=669
PosicionInicialArriba=453
PosicionInicialAlturaCliente=107
PosicionInicialAncho=342
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaExclusivaOpcion=0
BarraHerramientas=S
Comentarios=Lista(Info.Titulo)
[Variables]
Estilo=Ficha
Clave=Variables
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Plata
ListaEnCaptura=Temp.Texto

FichaNombres=Izquierda
FichaAlineacion=Izquierda
PermiteEditar=S
[Variables.Temp.Texto]
Carpeta=Variables
Clave=Temp.Texto
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreEnBoton=S
NombreDesplegar=Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

NombreEnBoton=S






















































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
