[Forma]
Clave=Aduana
Nombre=Aduanas
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=263
PosicionInicialArriba=298
PosicionInicialAltura=345
PosicionInicialAncho=754
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionInicialAlturaCliente=400

[Aduana.Columnas]
Aduana=104

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Aduana
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaAjustarColumnas=S
PermiteEditar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.Aduana.Aduana]
Carpeta=Lista
Clave=Aduana.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Aduana=194
Descripcion=325
Seccion=46
Denominacion=247
GLN=105
Ciudad=130

[Detalles.Aduana.Aduana]
Carpeta=Detalles
Clave=Aduana.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.Aduana.Icono]
Carpeta=Detalles
Clave=Aduana.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Aduana:Aduana.Aduana)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Lista.Aduana.Seccion]
Carpeta=Lista
Clave=Aduana.Seccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Aduana.Denominacion]
Carpeta=Lista
Clave=Aduana.Denominacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Aduana.GLN]
Carpeta=Lista
Clave=Aduana.GLN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Aduana.Ciudad]
Carpeta=Lista
Clave=Aduana.Ciudad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Aduana.Aduana
Aduana.Aduana=Aduana.Seccion
Aduana.Seccion=Aduana.Denominacion
Aduana.Denominacion=Aduana.GLN
Aduana.GLN=Aduana.Ciudad
Aduana.Ciudad=(Fin)
