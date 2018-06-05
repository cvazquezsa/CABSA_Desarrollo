[Forma]
Clave=NomXGasto
Nombre=Gastos
Icono=34
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=400
PosicionInicialArriba=128
PosicionInicialAltura=487
PosicionInicialAncho=800
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=31
Comentarios=Info.Nombre
PosicionInicialAlturaCliente=575

PosicionCol1=235
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomXGasto
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NomXGasto.Concepto
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
OtroOrden=S
ListaOrden=NomXGasto.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NomXGasto.ID={Info.ID}

[Lista.NomXGasto.Concepto]
Carpeta=Lista
Clave=NomXGasto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=202

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NomXGasto
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.NomXGasto.Concepto]
Carpeta=Ficha
Clave=NomXGasto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.NomXGasto.Condicion]
Carpeta=Ficha
Clave=NomXGasto.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.NomXGasto.Comentarios]
Carpeta=Ficha
Clave=NomXGasto.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S
EnBarraHerramientas=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(NomXGasto:NomXGasto.Concepto)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Ficha.NomXGasto.Acreedor]
Carpeta=Ficha
Clave=NomXGasto.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco

[Ficha.NomXGasto.Importe]
Carpeta=Ficha
Clave=NomXGasto.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco

[Ficha.NomXGasto.Vencimiento]
Carpeta=Ficha
Clave=NomXGasto.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco

[Ficha.NomXGasto.Movimiento]
Carpeta=Ficha
Clave=NomXGasto.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco

[Ficha.NomXGasto.Referencia]
Carpeta=Ficha
Clave=NomXGasto.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco

[Ficha.NomXGasto.ContUso]
Carpeta=Ficha
Clave=NomXGasto.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco

[Ficha.NomXGasto.UEN]
Carpeta=Ficha
Clave=NomXGasto.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco



[Ficha.ListaEnCaptura]
(Inicio)=NomXGasto.Movimiento
NomXGasto.Movimiento=NomXGasto.Acreedor
NomXGasto.Acreedor=NomXGasto.Vencimiento
NomXGasto.Vencimiento=NomXGasto.Concepto
NomXGasto.Concepto=NomXGasto.Referencia
NomXGasto.Referencia=NomXGasto.Importe
NomXGasto.Importe=NomXGasto.ContUso
NomXGasto.ContUso=NomXGasto.UEN
NomXGasto.UEN=NomXGasto.Condicion
NomXGasto.Condicion=NomXGasto.Comentarios
NomXGasto.Comentarios=NomXGasto.ClavePresupuestal
NomXGasto.ClavePresupuestal=(Fin)

[Ficha.NomXGasto.ClavePresupuestal]
Carpeta=Ficha
Clave=NomXGasto.ClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)
