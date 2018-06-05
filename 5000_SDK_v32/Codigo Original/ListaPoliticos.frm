[Forma]
Clave=ListaPoliticos
Nombre=Lista Politicos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=242
PosicionInicialArriba=275
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
Vista=ListaPoliticos
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
ListaOrden=ListaPoliticos.Nombre<TAB>(Acendente)

[Lista.ListaPoliticos.Nombre]
Carpeta=Lista
Clave=ListaPoliticos.Nombre
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

[Datos.ListaPoliticos.Datos]
Carpeta=Datos
Clave=ListaPoliticos.Datos
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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ListaPoliticos:ListaPoliticos.Nombre)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.ListaPoliticos.Datos]
Carpeta=Lista
Clave=ListaPoliticos.Datos
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

[Lista.ListaPoliticos.Registro]
Carpeta=Lista
Clave=ListaPoliticos.Registro
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
(Inicio)=ListaPoliticos.Nombre
ListaPoliticos.Nombre=ListaPoliticos.Registro
ListaPoliticos.Registro=ListaPoliticos.Datos
ListaPoliticos.Datos=(Fin)
