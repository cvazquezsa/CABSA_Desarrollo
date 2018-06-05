[Forma]
Clave=NomXPersonal
Nombre=Recibo
Icono=34
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=393
PosicionInicialArriba=105
PosicionInicialAltura=499
PosicionInicialAncho=814
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=28
Comentarios=Info.Nombre
PosicionInicialAlturaCliente=621
PosicionCol1=217

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomXPersonal
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NomXPersonal.Concepto
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
OtroOrden=S
ListaOrden=NomXPersonal.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NomXPersonal.ID={Info.ID}

[Lista.NomXPersonal.Concepto]
Carpeta=Lista
Clave=NomXPersonal.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=184

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NomXPersonal
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

[Ficha.NomXPersonal.Concepto]
Carpeta=Ficha
Clave=NomXPersonal.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
Efectos=[Negritas]

[Ficha.NomXPersonal.Condicion]
Carpeta=Ficha
Clave=NomXPersonal.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65x2
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.NomXPersonal.Cantidad]
Carpeta=Ficha
Clave=NomXPersonal.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65x3
ColorFondo=Blanco
EspacioPrevio=N

[Ficha.NomXPersonal.Percepcion]
Carpeta=Ficha
Clave=NomXPersonal.Percepcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65x3
ColorFondo=Blanco

[Ficha.NomXPersonal.Deduccion]
Carpeta=Ficha
Clave=NomXPersonal.Deduccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65x3
ColorFondo=Blanco
EspacioPrevio=N

[Ficha.NomXPersonal.Comentarios]
Carpeta=Ficha
Clave=NomXPersonal.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco

[Ficha.NomXPersonal.Importe]
Carpeta=Ficha
Clave=NomXPersonal.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65x3
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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(NomXPersonal:NomXPersonal.Concepto)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreEnBoton=S
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Forma(<T>NomXPersonalOrdenar<T>)

[Acciones.Localizar]
Nombre=Localizar
Boton=73
NombreEnBoton=S
NombreDesplegar=&Localizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Ficha.NomXPersonal.Aplica]
Carpeta=Ficha
Clave=NomXPersonal.Aplica
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
Efectos=[Negritas]
Pegado=S

[Ficha.NomXPersonal.Acum]
Carpeta=Ficha
Clave=NomXPersonal.Acum
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65x6
ColorFondo=Blanco

[Acciones.Acumuladores]
Nombre=Acumuladores
Boton=51
NombreEnBoton=S
NombreDesplegar=&Acumuladores
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Si(Forma(<T>NomXAcum<T>), Asigna(NomXPersonal:NomXPersonal.Acum, Temp.Texto))
Activo=S
Visible=S

[Acciones.Lista]
Nombre=Lista
Boton=91
NombreEnBoton=S
NombreDesplegar=<T>&Lista<T>
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NomXPersonalGrupo
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=NomXPersonal:NomXPersonal.Aplica en (<T>Todos menos Lista<T>, <T>Lista<T>)
EjecucionCondicion=ConDatos(NomXPersonal:NomXPersonal.Concepto)
AntesExpresiones=Asigna(Info.Concepto, NomXPersonal:NomXPersonal.Concepto)

[Ficha.NomXPersonal.CuentaDebe]
Carpeta=Ficha
Clave=NomXPersonal.CuentaDebe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco
EspacioPrevio=N

[Ficha.NomXPersonal.CuentaHaber]
Carpeta=Ficha
Clave=NomXPersonal.CuentaHaber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco

[Ficha.NomXPersonal.CuentaContAuto]
Carpeta=Ficha
Clave=NomXPersonal.CuentaContAuto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco

[Ficha.NomXPersonal.Referencia]
Carpeta=Ficha
Clave=NomXPersonal.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco

[Ficha.NomXPersonal.ObligacionFiscal]
Carpeta=Ficha
Clave=NomXPersonal.ObligacionFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco



[Ficha.ListaEnCaptura]
(Inicio)=NomXPersonal.Concepto
NomXPersonal.Concepto=NomXPersonal.Aplica
NomXPersonal.Aplica=NomXPersonal.Percepcion
NomXPersonal.Percepcion=NomXPersonal.Deduccion
NomXPersonal.Deduccion=NomXPersonal.Acum
NomXPersonal.Acum=NomXPersonal.Cantidad
NomXPersonal.Cantidad=NomXPersonal.Importe
NomXPersonal.Importe=NomXPersonal.CuentaDebe
NomXPersonal.CuentaDebe=NomXPersonal.CuentaHaber
NomXPersonal.CuentaHaber=NomXPersonal.CuentaContAuto
NomXPersonal.CuentaContAuto=NomXPersonal.Referencia
NomXPersonal.Referencia=NomXPersonal.ObligacionFiscal
NomXPersonal.ObligacionFiscal=NomXPersonal.Condicion
NomXPersonal.Condicion=NomXPersonal.Comentarios
NomXPersonal.Comentarios=NomXPersonal.ClavePresupuestal
NomXPersonal.ClavePresupuestal=(Fin)

[Ficha.NomXPersonal.ClavePresupuestal]
Carpeta=Ficha
Clave=NomXPersonal.ClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
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
Eliminar=Localizar
Localizar=Ordenar
Ordenar=Acumuladores
Acumuladores=Lista
Lista=Navegador
Navegador=(Fin)
