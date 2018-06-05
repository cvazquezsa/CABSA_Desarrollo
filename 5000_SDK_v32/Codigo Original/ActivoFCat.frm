[Forma]
Clave=ActivoFCat
Nombre=Categorías de Activos Fijos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=305
PosicionInicialArriba=144
PosicionInicialAltura=349
PosicionInicialAncho=675
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=401
PosicionColumna1=52
PosicionCol1=341

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFCat
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ActivoFCat.Categoria
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=Cta.Descripcion
HojaMantenerSeleccion=S

[Lista.ActivoFCat.Categoria]
Carpeta=Lista
Clave=ActivoFCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
Categoria=308
VidaUtil=100
MantenimientoPeriodicidad=91
Cuenta=99
Descripcion=154
InicioDepreciacion=94
MetodoDepreciacion=78
Formula=604
CuentaFiscal=100
Propietario=55
DepreciacionAnual=111

0=207
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

[Acciones.Navegador 2 (Registros)]
Nombre=Navegador 2 (Registros)
Boton=0
NombreDesplegar=Navegador 2 (Registros)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Contable]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contable
Clave=Contable
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ActivoFCat
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

[Contable.ActivoFCat.Categoria]
Carpeta=Contable
Clave=ActivoFCat.Categoria
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
Efectos=[Negritas]

[Contable.ActivoFCat.DepreciacionAnual]
Carpeta=Contable
Clave=ActivoFCat.DepreciacionAnual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contable.ActivoFCat.VidaUtil]
Carpeta=Contable
Clave=ActivoFCat.VidaUtil
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contable.ActivoFCat.InicioDepreciacion]
Carpeta=Contable
Clave=ActivoFCat.InicioDepreciacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Contable.ActivoFCat.MetodoDepreciacion]
Carpeta=Contable
Clave=ActivoFCat.MetodoDepreciacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contable.ActivoFCat.ValorDesecho]
Carpeta=Contable
Clave=ActivoFCat.ValorDesecho
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contable.ActivoFCat.DepreciacionAnualAjustada]
Carpeta=Contable
Clave=ActivoFCat.DepreciacionAnualAjustada
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ActivoFCat
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

[Ficha.ActivoFCat.Categoria]
Carpeta=Ficha
Clave=ActivoFCat.Categoria
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Ficha.ActivoFCat.Cuenta]
Carpeta=Ficha
Clave=ActivoFCat.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.ActivoFCat.CuentaFiscal]
Carpeta=Ficha
Clave=ActivoFCat.CuentaFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.ActivoFCat.Propietario]
Carpeta=Ficha
Clave=ActivoFCat.Propietario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.Cta.Descripcion]
Carpeta=Ficha
Clave=Cta.Descripcion
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ValidaNombre=S

[Ficha.CtaDestino.Descripcion]
Carpeta=Ficha
Clave=CtaDestino.Descripcion
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ValidaNombre=S

[Ficha.ActivoFCat.MantenimientoPeriodicidad]
Carpeta=Ficha
Clave=ActivoFCat.MantenimientoPeriodicidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Fiscal]
Estilo=Ficha
Pestana=S
Clave=Fiscal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ActivoFCat
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
PestanaOtroNombre=S
PestanaNombre=Fiscal

[Fiscal.ActivoFCat.DepreciacionAnualF]
Carpeta=Fiscal
Clave=ActivoFCat.DepreciacionAnualF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fiscal.ActivoFCat.VidaUtilF]
Carpeta=Fiscal
Clave=ActivoFCat.VidaUtilF
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fiscal.ActivoFCat.InicioDepreciacionF]
Carpeta=Fiscal
Clave=ActivoFCat.InicioDepreciacionF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.ActivoFCat.MetodoDepreciacionF]
Carpeta=Fiscal
Clave=ActivoFCat.MetodoDepreciacionF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.ActivoFCat.ValorDesechoF]
Carpeta=Fiscal
Clave=ActivoFCat.ValorDesechoF
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fiscal.ActivoFCat.DepreciacionAnualAjustadaF]
Carpeta=Fiscal
Clave=ActivoFCat.DepreciacionAnualAjustadaF
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=41
EspacioPrevio=S

[Fiscal.ActivoFCat.Categoria]
Carpeta=Fiscal
Clave=ActivoFCat.Categoria
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fiscal IETU
Clave=Fiscal2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ActivoFCat
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Fiscal2.ActivoFCat.Categoria]
Carpeta=Fiscal2
Clave=ActivoFCat.Categoria
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoFCat.DepreciacionAnualF2]
Carpeta=Fiscal2
Clave=ActivoFCat.DepreciacionAnualF2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal2.ActivoFCat.VidaUtilF2]
Carpeta=Fiscal2
Clave=ActivoFCat.VidaUtilF2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal2.ActivoFCat.InicioDepreciacionF2]
Carpeta=Fiscal2
Clave=ActivoFCat.InicioDepreciacionF2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal2.ActivoFCat.MetodoDepreciacionF2]
Carpeta=Fiscal2
Clave=ActivoFCat.MetodoDepreciacionF2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal2.ActivoFCat.ValorDesechoF2]
Carpeta=Fiscal2
Clave=ActivoFCat.ValorDesechoF2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal2.ActivoFCat.DepreciacionAnualAjustadaF2]
Carpeta=Fiscal2
Clave=ActivoFCat.DepreciacionAnualAjustadaF2
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Contable.ActivoFCat.PorcentajeDeducible]
Carpeta=Contable
Clave=ActivoFCat.PorcentajeDeducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco





[Fiscal.ListaEnCaptura]
(Inicio)=ActivoFCat.Categoria
ActivoFCat.Categoria=ActivoFCat.DepreciacionAnualF
ActivoFCat.DepreciacionAnualF=ActivoFCat.VidaUtilF
ActivoFCat.VidaUtilF=ActivoFCat.InicioDepreciacionF
ActivoFCat.InicioDepreciacionF=ActivoFCat.MetodoDepreciacionF
ActivoFCat.MetodoDepreciacionF=ActivoFCat.ValorDesechoF
ActivoFCat.ValorDesechoF=ActivoFCat.DepreciacionAnualAjustadaF
ActivoFCat.DepreciacionAnualAjustadaF=(Fin)

[Fiscal2.ListaEnCaptura]
(Inicio)=ActivoFCat.Categoria
ActivoFCat.Categoria=ActivoFCat.DepreciacionAnualF2
ActivoFCat.DepreciacionAnualF2=ActivoFCat.VidaUtilF2
ActivoFCat.VidaUtilF2=ActivoFCat.InicioDepreciacionF2
ActivoFCat.InicioDepreciacionF2=ActivoFCat.MetodoDepreciacionF2
ActivoFCat.MetodoDepreciacionF2=ActivoFCat.ValorDesechoF2
ActivoFCat.ValorDesechoF2=ActivoFCat.DepreciacionAnualAjustadaF2
ActivoFCat.DepreciacionAnualAjustadaF2=(Fin)







[Contable.ListaEnCaptura]
(Inicio)=ActivoFCat.Categoria
ActivoFCat.Categoria=ActivoFCat.DepreciacionAnual
ActivoFCat.DepreciacionAnual=ActivoFCat.VidaUtil
ActivoFCat.VidaUtil=ActivoFCat.InicioDepreciacion
ActivoFCat.InicioDepreciacion=ActivoFCat.MetodoDepreciacion
ActivoFCat.MetodoDepreciacion=ActivoFCat.ValorDesecho
ActivoFCat.ValorDesecho=ActivoFCat.DepreciacionAnualAjustada
ActivoFCat.DepreciacionAnualAjustada=ActivoFCat.PorcentajeDeducible
ActivoFCat.PorcentajeDeducible=(Fin)








[Ficha.ActivoFCat.CuentaDepreciacion]
Carpeta=Ficha
Clave=ActivoFCat.CuentaDepreciacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Ficha.ListaEnCaptura]
(Inicio)=ActivoFCat.Categoria
ActivoFCat.Categoria=ActivoFCat.MantenimientoPeriodicidad
ActivoFCat.MantenimientoPeriodicidad=ActivoFCat.Cuenta
ActivoFCat.Cuenta=Cta.Descripcion
Cta.Descripcion=ActivoFCat.CuentaFiscal
ActivoFCat.CuentaFiscal=CtaDestino.Descripcion
CtaDestino.Descripcion=ActivoFCat.CuentaDepreciacion
ActivoFCat.CuentaDepreciacion=ActivoFCat.Propietario
ActivoFCat.Propietario=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Contable
Contable=Fiscal
Fiscal=Fiscal2
Fiscal2=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=Nuevo
Nuevo=Eliminar
Eliminar=Navegador 2 (Registros)
Navegador 2 (Registros)=(Fin)
