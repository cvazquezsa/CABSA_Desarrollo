[Forma]
Clave=ServerImpresion
Nombre=Servidor de Impresiones
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=617
PosicionInicialArriba=376
PosicionInicialAltura=439
PosicionInicialAncho=685
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=41
PosicionInicialAlturaCliente=412
PosicionCol1=279

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServerImpresion
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
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
HojaMantenerSeleccion=S

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ServerImpresion
Fuente={MS Sans Serif, 8, Negro, []}
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
PermiteEditar=S

[Detalle.ServerImpresion.EstacionTrabajo]
Carpeta=Detalle
Clave=ServerImpresion.EstacionTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Modulo]
Carpeta=Detalle
Clave=ServerImpresion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Mov]
Carpeta=Detalle
Clave=ServerImpresion.Mov
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Serie]
Carpeta=Detalle
Clave=ServerImpresion.Serie
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Reporte]
Carpeta=Detalle
Clave=ServerImpresion.Reporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Impresora]
Carpeta=Detalle
Clave=ServerImpresion.Impresora
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Copias]
Carpeta=Detalle
Clave=ServerImpresion.Copias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Consecutivo]
Carpeta=Detalle
Clave=ServerImpresion.Consecutivo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
EstacionTrabajo=87
Modulo=79
Mov=95
Reporte=193
Impresora=183
Consecutivo=96
Empresa=62
Puerto=64
Archivo=117

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Lista.ServerImpresion.EstacionTrabajo]
Carpeta=Lista
Clave=ServerImpresion.EstacionTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Tiempo]
Carpeta=Detalle
Clave=ServerImpresion.Tiempo
Editar=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Activo]
Carpeta=Detalle
Clave=ServerImpresion.Activo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

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

[Detalle.ServerImpresion.Empresa]
Carpeta=Detalle
Clave=ServerImpresion.Empresa
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServerImpresion.Empresa]
Carpeta=Lista
Clave=ServerImpresion.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServerImpresion.Mov]
Carpeta=Lista
Clave=ServerImpresion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Puerto]
Carpeta=Detalle
Clave=ServerImpresion.Puerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Archivo]
Carpeta=Detalle
Clave=ServerImpresion.Archivo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.FormatoASCII]
Carpeta=Detalle
Clave=ServerImpresion.FormatoASCII
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.MovEstatus]
Carpeta=Detalle
Clave=ServerImpresion.MovEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.Prefijo]
Carpeta=Detalle
Clave=ServerImpresion.Prefijo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.ImprimirCancelados]
Carpeta=Detalle
Clave=ServerImpresion.ImprimirCancelados
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServerImpresion.FiltroUsuario]
Carpeta=Detalle
Clave=ServerImpresion.FiltroUsuario
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ServerImpresion.EstacionTrabajo
ServerImpresion.EstacionTrabajo=ServerImpresion.Empresa
ServerImpresion.Empresa=ServerImpresion.Mov
ServerImpresion.Mov=(Fin)

[Lista.ListaOrden]
(Inicio)=ServerImpresion.EstacionTrabajo<TAB>(Acendente)
ServerImpresion.EstacionTrabajo<TAB>(Acendente)=ServerImpresion.Empresa<TAB>(Acendente)
ServerImpresion.Empresa<TAB>(Acendente)=ServerImpresion.Mov<TAB>(Acendente)
ServerImpresion.Mov<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=ServerImpresion.EstacionTrabajo
ServerImpresion.EstacionTrabajo=ServerImpresion.Empresa
ServerImpresion.Empresa=ServerImpresion.Modulo
ServerImpresion.Modulo=ServerImpresion.Mov
ServerImpresion.Mov=ServerImpresion.Serie
ServerImpresion.Serie=ServerImpresion.MovEstatus
ServerImpresion.MovEstatus=ServerImpresion.Prefijo
ServerImpresion.Prefijo=ServerImpresion.Consecutivo
ServerImpresion.Consecutivo=ServerImpresion.Reporte
ServerImpresion.Reporte=ServerImpresion.Impresora
ServerImpresion.Impresora=ServerImpresion.FormatoASCII
ServerImpresion.FormatoASCII=ServerImpresion.Puerto
ServerImpresion.Puerto=ServerImpresion.Archivo
ServerImpresion.Archivo=ServerImpresion.Activo
ServerImpresion.Activo=ServerImpresion.FiltroUsuario
ServerImpresion.FiltroUsuario=ServerImpresion.ImprimirCancelados
ServerImpresion.ImprimirCancelados=ServerImpresion.Copias
ServerImpresion.Copias=ServerImpresion.Tiempo
ServerImpresion.Tiempo=(Fin)
