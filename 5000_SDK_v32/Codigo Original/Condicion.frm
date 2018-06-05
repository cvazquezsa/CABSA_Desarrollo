[Forma]
Clave=Condicion
Nombre=Condiciones Pago
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=47
PosicionInicialArriba=140
PosicionInicialAltura=423
PosicionInicialAncho=703
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
PosicionColumna1=51
PosicionInicialAlturaCliente=515
PosicionCol1=353

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Condicion
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Condicion.Condicion
CarpetaVisible=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CondicionGrupo
FiltroAplicaEn1=Condicion.Grupo
FiltroNullNombre=(sin grupo)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroNull=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

[Lista.Condicion.Condicion]
Carpeta=Lista
Clave=Condicion.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Condicion=172

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Condición
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Condicion
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

[Detalle.Condicion.Condicion]
Carpeta=Detalle
Clave=Condicion.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=29
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Condicion.DiasVencimiento]
Carpeta=Detalle
Clave=Condicion.DiasVencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Condicion:Condicion.Condicion)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
GuardarAntes=
GuardarConfirmar=
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Visible=S
Activo=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=Si
NombreDesplegar=E&liminar
EnBarraHerramientas=Si
ConfirmarAntes=Si
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=Si
Activo=Si

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Visible=S
Activo=S

[Detalle.Condicion.TipoDias]
Carpeta=Detalle
Clave=Condicion.TipoDias
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.DiasHabiles]
Carpeta=Detalle
Clave=Condicion.DiasHabiles
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.PorMeses]
Carpeta=Detalle
Clave=Condicion.PorMeses
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10
EspacioPrevio=S

[Detalle.Condicion.Meses]
Carpeta=Detalle
Clave=Condicion.Meses
Editar=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Detalle.Condicion.DA]
Carpeta=Detalle
Clave=Condicion.DA
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[DA]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Documentación Automática
Clave=DA
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Condicion
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
CondicionVisible=Condicion:Condicion.DA

[DA.Condicion.DANumeroDocumentos]
Carpeta=DA
Clave=Condicion.DANumeroDocumentos
Editar=S
LineaNueva=S
3D=S
Tamano=19
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[DA.Condicion.DAPeriodo]
Carpeta=DA
Clave=Condicion.DAPeriodo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DA.Condicion.DAImpPrimerDoc]
Carpeta=DA
Clave=Condicion.DAImpPrimerDoc
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[DA.Condicion.DAInteres]
Carpeta=DA
Clave=Condicion.DAInteres
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[DA.Condicion.DAInteresImpuesto]
Carpeta=DA
Clave=Condicion.DAInteresImpuesto
Editar=S
LineaNueva=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[DA.Condicion.DAInteresConcepto]
Carpeta=DA
Clave=Condicion.DAInteresConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DA.Condicion.Condicion]
Carpeta=DA
Clave=Condicion.Condicion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[AP.Condicion.APNumeroDocumentos]
Carpeta=AP
Clave=Condicion.APNumeroDocumentos
Editar=S
LineaNueva=S
3D=S
Tamano=19
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[AP.Condicion.APPeriodo]
Carpeta=AP
Clave=Condicion.APPeriodo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AP.Condicion.Condicion]
Carpeta=AP
Clave=Condicion.Condicion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
AntesExpresiones=Forma(<T>CondicionOrdenar<T>)
DespuesGuardar=S

[PA.Condicion.Condicion]
Carpeta=PA
Clave=Condicion.Condicion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Condicion.AnticipadoPeriodo]
Carpeta=Detalle
Clave=Condicion.AnticipadoPeriodo
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Detalle.Condicion.AnticipadoNumero]
Carpeta=Detalle
Clave=Condicion.AnticipadoNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.ControlAnticipos]
Carpeta=Detalle
Clave=Condicion.ControlAnticipos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.ProntoPago]
Carpeta=Detalle
Clave=Condicion.ProntoPago
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[PP]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pronto Pago Fijo
Clave=PP
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Condicion
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
CondicionVisible=Condicion:Condicion.ProntoPago

[PP.Condicion.DiasProntoPago]
Carpeta=PP
Clave=Condicion.DiasProntoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[PP.Condicion.DescuentoProntoPago]
Carpeta=PP
Clave=Condicion.DescuentoProntoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[PP.Condicion.TipoDiasProntoPago]
Carpeta=PP
Clave=Condicion.TipoDiasProntoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[PP.Condicion.DiasHabilesProntoPago]
Carpeta=PP
Clave=Condicion.DiasHabilesProntoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.Corte]
Carpeta=Detalle
Clave=Condicion.Corte
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Condicion.CorteDia]
Carpeta=Detalle
Clave=Condicion.CorteDia
Editar=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.Grupo]
Carpeta=Detalle
Clave=Condicion.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=29
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreDesplegar=&Grupos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CondicionGrupo
Activo=S
Visible=S
NombreEnBoton=S

[Ford]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ford
Clave=Ford
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Condicion
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
CondicionVisible=General.Ford

[Ford.Condicion.TipoPago]
Carpeta=Ford
Clave=Condicion.TipoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ford.Condicion.PagoMensual]
Carpeta=Ford
Clave=Condicion.PagoMensual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ford.Condicion.Termino]
Carpeta=Ford
Clave=Condicion.Termino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ford.Condicion.Interes]
Carpeta=Ford
Clave=Condicion.Interes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ford.Condicion.TipoVenta]
Carpeta=Ford
Clave=Condicion.TipoVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.NivelAcceso]
Carpeta=Detalle
Clave=Condicion.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[PP.Condicion.FechaProntoPago]
Carpeta=PP
Clave=Condicion.FechaProntoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Auto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Autotransportes
Clave=Auto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Condicion
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
CondicionVisible=General.Autotransportes

[Auto.Condicion.AutoCobroDef]
Carpeta=Auto
Clave=Condicion.AutoCobroDef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Condicion.AutoCobroPorcentajeDef]
Carpeta=Auto
Clave=Condicion.AutoCobroPorcentajeDef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.TipoCondicion]
Carpeta=Detalle
Clave=Condicion.TipoCondicion
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ford.Condicion.InteresMoratorioBaseTabla]
Carpeta=Ford
Clave=Condicion.InteresMoratorioBaseTabla
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ford.Condicion.AutoFin]
Carpeta=Ford
Clave=Condicion.AutoFin
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ford.Condicion.AutoFinPedidoComision]
Carpeta=Ford
Clave=Condicion.AutoFinPedidoComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ford.Condicion.AutoFinPedidoTipo]
Carpeta=Ford
Clave=Condicion.AutoFinPedidoTipo
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Ford.Condicion.AutoFinFacturaComision]
Carpeta=Ford
Clave=Condicion.AutoFinFacturaComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ford.Condicion.AutoFinFacturaTipo]
Carpeta=Ford
Clave=Condicion.AutoFinFacturaTipo
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.Neteo]
Carpeta=Detalle
Clave=Condicion.Neteo
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Intereses.Condicion.TasaBase]
Carpeta=Intereses
Clave=Condicion.TasaBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Intereses.Condicion.TasaPorcentaje]
Carpeta=Intereses
Clave=Condicion.TasaPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Intereses.Condicion.TasaDias]
Carpeta=Intereses
Clave=Condicion.TasaDias
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
LineaNueva=S

[ID]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Intereses Devengados
Clave=ID
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Condicion
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
ListaEnCaptura=Condicion.Tasa
CondicionVisible=Condicion:Condicion.InteresesDevengados

[ID.Condicion.Tasa]
Carpeta=ID
Clave=Condicion.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.InteresesDevengados]
Carpeta=Detalle
Clave=Condicion.InteresesDevengados
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[DA.Condicion.DATipoInteres]
Carpeta=DA
Clave=Condicion.DATipoInteres
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.FacturaCobroIntegradoParcial]
Carpeta=Detalle
Clave=Condicion.FacturaCobroIntegradoParcial
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.PorSemanas]
Carpeta=Detalle
Clave=Condicion.PorSemanas
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Condicion.Semanas]
Carpeta=Detalle
Clave=Condicion.Semanas
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro

[DA.Condicion.DADiaEspecifico]
Carpeta=DA
Clave=Condicion.DADiaEspecifico
Editar=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[CFD]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=CFD
Clave=CFD
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Condicion
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

CondicionVisible=(Empresa.CFD) o (General.CFDFlex)
[CFD.Condicion.CFD_formaDePago]
Carpeta=CFD
Clave=Condicion.CFD_formaDePago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFD.Condicion.CFD_metodoDePago]
Carpeta=CFD
Clave=Condicion.CFD_metodoDePago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Lista.ListaOrden]
(Inicio)=Condicion.Orden<TAB>(Acendente)
Condicion.Orden<TAB>(Acendente)=Condicion.Condicion<TAB>(Acendente)
Condicion.Condicion<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=Condicion.Condicion
Condicion.Condicion=Condicion.TipoCondicion
Condicion.TipoCondicion=Condicion.DiasVencimiento
Condicion.DiasVencimiento=Condicion.TipoDias
Condicion.TipoDias=Condicion.DiasHabiles
Condicion.DiasHabiles=Condicion.PorMeses
Condicion.PorMeses=Condicion.Meses
Condicion.Meses=Condicion.PorSemanas
Condicion.PorSemanas=Condicion.Semanas
Condicion.Semanas=Condicion.ControlAnticipos
Condicion.ControlAnticipos=Condicion.AnticipadoNumero
Condicion.AnticipadoNumero=Condicion.AnticipadoPeriodo
Condicion.AnticipadoPeriodo=Condicion.Corte
Condicion.Corte=Condicion.CorteDia
Condicion.CorteDia=Condicion.DA
Condicion.DA=Condicion.InteresesDevengados
Condicion.InteresesDevengados=Condicion.ProntoPago
Condicion.ProntoPago=Condicion.Neteo
Condicion.Neteo=Condicion.FacturaCobroIntegradoParcial
Condicion.FacturaCobroIntegradoParcial=Condicion.Grupo
Condicion.Grupo=Condicion.NivelAcceso
Condicion.NivelAcceso=(Fin)

[DA.ListaEnCaptura]
(Inicio)=Condicion.Condicion
Condicion.Condicion=Condicion.DANumeroDocumentos
Condicion.DANumeroDocumentos=Condicion.DAPeriodo
Condicion.DAPeriodo=Condicion.DADiaEspecifico
Condicion.DADiaEspecifico=Condicion.DAInteres
Condicion.DAInteres=Condicion.DATipoInteres
Condicion.DATipoInteres=Condicion.DAInteresImpuesto
Condicion.DAInteresImpuesto=Condicion.DAInteresConcepto
Condicion.DAInteresConcepto=Condicion.DAImpPrimerDoc
Condicion.DAImpPrimerDoc=(Fin)

[PP.ListaEnCaptura]
(Inicio)=Condicion.FechaProntoPago
Condicion.FechaProntoPago=Condicion.DiasProntoPago
Condicion.DiasProntoPago=Condicion.DescuentoProntoPago
Condicion.DescuentoProntoPago=Condicion.TipoDiasProntoPago
Condicion.TipoDiasProntoPago=Condicion.DiasHabilesProntoPago
Condicion.DiasHabilesProntoPago=(Fin)

[Ford.ListaEnCaptura]
(Inicio)=Condicion.TipoVenta
Condicion.TipoVenta=Condicion.TipoPago
Condicion.TipoPago=Condicion.PagoMensual
Condicion.PagoMensual=Condicion.Termino
Condicion.Termino=Condicion.Interes
Condicion.Interes=Condicion.InteresMoratorioBaseTabla
Condicion.InteresMoratorioBaseTabla=Condicion.AutoFin
Condicion.AutoFin=Condicion.AutoFinPedidoComision
Condicion.AutoFinPedidoComision=Condicion.AutoFinPedidoTipo
Condicion.AutoFinPedidoTipo=Condicion.AutoFinFacturaComision
Condicion.AutoFinFacturaComision=Condicion.AutoFinFacturaTipo
Condicion.AutoFinFacturaTipo=(Fin)

[Auto.ListaEnCaptura]
(Inicio)=Condicion.AutoCobroDef
Condicion.AutoCobroDef=Condicion.AutoCobroPorcentajeDef
Condicion.AutoCobroPorcentajeDef=(Fin)






[CFD.ListaEnCaptura]
(Inicio)=Condicion.CFD_formaDePago
Condicion.CFD_formaDePago=Condicion.CFD_metodoDePago
Condicion.CFD_metodoDePago=Condicion.DiferirFechaAcumulacion
Condicion.DiferirFechaAcumulacion=(Fin)

[CFD.Condicion.DiferirFechaAcumulacion]
Carpeta=CFD
Clave=Condicion.DiferirFechaAcumulacion
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=DA
DA=ID
ID=PP
PP=Ford
Ford=Auto
Auto=CFD
CFD=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Ordenar
Ordenar=Grupos
Grupos=Navegador
Navegador=(Fin)
