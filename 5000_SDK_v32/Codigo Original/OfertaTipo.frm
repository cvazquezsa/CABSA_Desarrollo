[Forma]
Clave=OfertaTipo
Nombre=Tipos Ofertas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=690
PosicionInicialArriba=319
PosicionInicialAlturaCliente=362
PosicionInicialAncho=540
PosicionCol1=287
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSec1=388

[Lista.Columnas]
Metodo=206
Tipo=256
Nombre=204
Forma=141
Usar=125
Estatus=111
TieneVolumen=48

0=-2
Orden=64
[Lista.OfertaTipo.Tipo]
Carpeta=Lista
Clave=OfertaTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[(Carpeta Abrir).OfertaTipo.Nombre]
Carpeta=(Carpeta Abrir)
Clave=OfertaTipo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=102
1=475

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OfertaTipo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=OfertaTipo.Tipo
CarpetaVisible=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaMantenerSeleccion=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(OfertaTipo:OfertaTipo.Tipo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S
Visible=S

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=OfertaTipo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.OfertaTipo.TieneVolumen]
Carpeta=Ficha
Clave=OfertaTipo.TieneVolumen
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.OfertaTipo.Usar]
Carpeta=Ficha
Clave=OfertaTipo.Usar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.OfertaTipo.Forma]
Carpeta=Ficha
Clave=OfertaTipo.Forma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.OfertaTipo.Tipo]
Carpeta=Ficha
Clave=OfertaTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S




[Ficha.OfertaTipo.AceptaDevolucion]
Carpeta=Ficha
Clave=OfertaTipo.AceptaDevolucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


















[Ficha.OfertaTipo.Orden]
Carpeta=Ficha
Clave=OfertaTipo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco































[Ficha.ListaEnCaptura]
(Inicio)=OfertaTipo.Tipo
OfertaTipo.Tipo=OfertaTipo.Forma
OfertaTipo.Forma=OfertaTipo.Usar
OfertaTipo.Usar=OfertaTipo.TieneVolumen
OfertaTipo.TieneVolumen=OfertaTipo.AceptaDevolucion
OfertaTipo.AceptaDevolucion=OfertaTipo.Orden
OfertaTipo.Orden=(Fin)























































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)
