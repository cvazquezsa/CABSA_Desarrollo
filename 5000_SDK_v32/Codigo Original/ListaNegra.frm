[Forma]
Clave=ListaNegra
Nombre=Lista Negra (Contactos)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=114
PosicionInicialArriba=144
PosicionInicialAltura=473
PosicionInicialAncho=796
PosicionColumna1=41
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=446

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaNegra
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
OtroOrden=S
ListaOrden=ListaNegra.Nombre<TAB>(Acendente)

[Lista.ListaNegra.Nombre]
Carpeta=Lista
Clave=ListaNegra.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Nombre=353
Datos=289
Registro=124

[Datos.ListaNegra.Datos]
Carpeta=Datos
Clave=ListaNegra.Datos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=50x4

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ListaNegra:ListaNegra.Nombre)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.ListaNegra.Datos]
Carpeta=Lista
Clave=ListaNegra.Datos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Enviar/Recibir Excel]
Nombre=Enviar/Recibir Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Lista.ListaNegra.Registro]
Carpeta=Lista
Clave=ListaNegra.Registro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Enviar/Recibir Excel
Enviar/Recibir Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ListaNegra.Nombre
ListaNegra.Nombre=ListaNegra.Registro
ListaNegra.Registro=ListaNegra.Datos
ListaNegra.Datos=(Fin)
