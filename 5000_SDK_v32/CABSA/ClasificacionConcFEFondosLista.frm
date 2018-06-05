
[Forma]
Clave=ClasificacionConcFEFondosLista
Icono=0
Modulos=(Todos)
Nombre=Clasificación Flujo Efectivo Fondos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=342
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaColor=Plata
PosicionInicialIzquierda=789
PosicionInicialArriba=364
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ClasificacionConcFEFondos
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ClasificacionConcFEFondos.Clasificacion
CarpetaVisible=S

[Lista.ClasificacionConcFEFondos.Clasificacion]
Carpeta=Lista
Clave=ClasificacionConcFEFondos.Clasificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Clasificacion=304

[Acciones.Seleccionar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Aceptar
Aceptar=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cerrar
Cerrar=(Fin)
