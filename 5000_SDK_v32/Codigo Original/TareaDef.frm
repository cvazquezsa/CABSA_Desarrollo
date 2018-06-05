[Forma]
Clave=TareaDef
Nombre=Tareas por Omisión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=370
PosicionInicialArriba=305
PosicionInicialAltura=300
PosicionInicialAncho=539
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=387

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TareaDef
Fuente={MS Sans Serif, 8, Negro, []}
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
ListaOrden=TareaDef.Categoria<TAB>(Acendente)
CarpetaVisible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Tarea=276
Categoria=168
Tiempo=64

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Acciones.TareaCat]
Nombre=TareaCat
Boton=91
NombreEnBoton=S
NombreDesplegar=&Categorías
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TareaCat
Activo=S
Visible=S

[Lista.TareaDef.Tarea]
Carpeta=Lista
Clave=TareaDef.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TareaDef.Categoria]
Carpeta=Lista
Clave=TareaDef.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TareaDef.Tiempo]
Carpeta=Lista
Clave=TareaDef.Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=TareaCat
TareaCat=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TareaDef.Tarea
TareaDef.Tarea=TareaDef.Categoria
TareaDef.Categoria=TareaDef.Tiempo
TareaDef.Tiempo=(Fin)
